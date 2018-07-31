import re
from urllib.request import urlopen

HTTP_CLIENT_VERSION = '0.5.13.1'

def mk_url(module):
    return 'http://hackage.haskell.org/package/http-client-{}/src/{}.hs'.format(HTTP_CLIENT_VERSION, module.replace('.', '/'))

def lines(resp):
    while True:
        raw = resp.readline()
        if not raw:
            break
        yield raw.decode('utf8').rstrip()

field_re = re.compile(r' +[{,] (?P<name>\S+) :: (?P<type>.+)')
comment_re = re.compile(r'( +--.*)?')

def extract_fields(lines, stype):
    for line in lines:
        if line.startswith('data {} '.format(stype)):
            break
    for line in lines:
        if line == '    }':
            break
        m = field_re.fullmatch(line)
        if m is None:
            assert comment_re.fullmatch(line) is not None
        else:
            yield m['name'], m['type']

def scrape(lines, ignore, stypes):
    specs = []
    for stype in stypes:
        fields = []
        for name, atype in extract_fields(lines, stype):
            if name not in ignore:
                fields.append((name, atype))
        specs.append((stype, fields))
    return specs

def parens(s):
    return ('({})' if ' ' in s else '{}').format(s)

def mk_lens(name, stype, atype):
    yield "{} :: Lens' {} {}".format(name, parens(stype), parens(atype))
    yield r'{} = lens I.{} $ \s b -> s {{ I.{} = b }}'.format(name, name, name)

def mk_imports(specs, docs):
    first = True
    for stype, fields in specs:
        if docs:
            yield '      -- * {}'.format(stype.split(' ')[0])
        for name, _ in fields:
            delim = ' ' if first else ','
            first = False
            yield '    {} {}'.format(delim, name)

def mk_module(specs):
    yield 'module Network.HTTP.Client.Lens.Internal.Gen'
    yield '    ('
    yield from mk_imports(specs, True)
    yield '    ) where'
    yield ''
    yield "import qualified Network.HTTP.Client.Lens.Internal.Gen.Imports as I"
    yield "import qualified Network.HTTP.Client.Lens.Internal.Gen.Imports as S"
    yield "import Network.HTTP.Client.Lens.Internal.Gen.Imports hiding"
    yield '    ('
    yield from mk_imports(specs, False)
    yield '    )'
    for stype, fields in specs:
        for name, atype in fields:
            yield ''
            yield from mk_lens(name, stype, atype)

def main():
    with urlopen(mk_url('Network.HTTP.Client.Types')) as resp:
        ignore = set((
            'responseBody',
            ))
        stypes = (
            'Request',
            'Response body',
            )
        spec = scrape(lines(resp), ignore, stypes)
    with open('gen/Network/HTTP/Client/Lens/Internal/Gen.hs', 'w') as f:
        for line in mk_module(spec):
            f.write(line)
            f.write('\n')

if __name__ == '__main__':
    main()
