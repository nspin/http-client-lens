module Network.HTTP.Client.Lens.Internal.Gen
    (
      -- * Request
      method
    , secure
    , host
    , port
    , path
    , queryString
    , requestHeaders
    , requestBody
    , proxy
    , hostAddress
    , rawBody
    , decompress
    , redirectCount
    , checkResponse
    , responseTimeout
    , cookieJar
    , requestVersion
    , onRequestBodyException
    , requestManagerOverride
      -- * Response
    , responseStatus
    , responseVersion
    , responseHeaders
    , responseCookieJar
    , responseClose'
    ) where

import qualified Network.HTTP.Client.Lens.Internal.Gen.Imports as I
import qualified Network.HTTP.Client.Lens.Internal.Gen.Imports as S
import Network.HTTP.Client.Lens.Internal.Gen.Imports hiding
    (
      method
    , secure
    , host
    , port
    , path
    , queryString
    , requestHeaders
    , requestBody
    , proxy
    , hostAddress
    , rawBody
    , decompress
    , redirectCount
    , checkResponse
    , responseTimeout
    , cookieJar
    , requestVersion
    , onRequestBodyException
    , requestManagerOverride
    , responseStatus
    , responseVersion
    , responseHeaders
    , responseCookieJar
    , responseClose'
    )

method :: Lens' Request Method
method = lens I.method $ \s b -> s { I.method = b }

secure :: Lens' Request Bool
secure = lens I.secure $ \s b -> s { I.secure = b }

host :: Lens' Request S.ByteString
host = lens I.host $ \s b -> s { I.host = b }

port :: Lens' Request Int
port = lens I.port $ \s b -> s { I.port = b }

path :: Lens' Request S.ByteString
path = lens I.path $ \s b -> s { I.path = b }

queryString :: Lens' Request S.ByteString
queryString = lens I.queryString $ \s b -> s { I.queryString = b }

requestHeaders :: Lens' Request RequestHeaders
requestHeaders = lens I.requestHeaders $ \s b -> s { I.requestHeaders = b }

requestBody :: Lens' Request RequestBody
requestBody = lens I.requestBody $ \s b -> s { I.requestBody = b }

proxy :: Lens' Request (Maybe Proxy)
proxy = lens I.proxy $ \s b -> s { I.proxy = b }

hostAddress :: Lens' Request (Maybe HostAddress)
hostAddress = lens I.hostAddress $ \s b -> s { I.hostAddress = b }

rawBody :: Lens' Request Bool
rawBody = lens I.rawBody $ \s b -> s { I.rawBody = b }

decompress :: Lens' Request (S.ByteString -> Bool)
decompress = lens I.decompress $ \s b -> s { I.decompress = b }

redirectCount :: Lens' Request Int
redirectCount = lens I.redirectCount $ \s b -> s { I.redirectCount = b }

checkResponse :: Lens' Request (Request -> Response BodyReader -> IO ())
checkResponse = lens I.checkResponse $ \s b -> s { I.checkResponse = b }

responseTimeout :: Lens' Request ResponseTimeout
responseTimeout = lens I.responseTimeout $ \s b -> s { I.responseTimeout = b }

cookieJar :: Lens' Request (Maybe CookieJar)
cookieJar = lens I.cookieJar $ \s b -> s { I.cookieJar = b }

requestVersion :: Lens' Request HttpVersion
requestVersion = lens I.requestVersion $ \s b -> s { I.requestVersion = b }

onRequestBodyException :: Lens' Request (SomeException -> IO ())
onRequestBodyException = lens I.onRequestBodyException $ \s b -> s { I.onRequestBodyException = b }

requestManagerOverride :: Lens' Request (Maybe Manager)
requestManagerOverride = lens I.requestManagerOverride $ \s b -> s { I.requestManagerOverride = b }

responseStatus :: Lens' (Response body) Status
responseStatus = lens I.responseStatus $ \s b -> s { I.responseStatus = b }

responseVersion :: Lens' (Response body) HttpVersion
responseVersion = lens I.responseVersion $ \s b -> s { I.responseVersion = b }

responseHeaders :: Lens' (Response body) ResponseHeaders
responseHeaders = lens I.responseHeaders $ \s b -> s { I.responseHeaders = b }

responseCookieJar :: Lens' (Response body) CookieJar
responseCookieJar = lens I.responseCookieJar $ \s b -> s { I.responseCookieJar = b }

responseClose' :: Lens' (Response body) ResponseClose
responseClose' = lens I.responseClose' $ \s b -> s { I.responseClose' = b }
