{-# LANGUAGE TemplateHaskell #-}

module Network.HTTP.Client.Lens where

import Control.Lens

import Network.HTTP.Client
import Network.HTTP.Client.Internal

$(makeLensesWith (set lensField (mappingNamer ((:[]) . ('_':))) lensRules) ''Request)
$(makeLensesWith (set lensField (mappingNamer ((:[]) . ('_':))) lensRules) ''Response)
$(makeLensesWith (set lensField (mappingNamer ((:[]) . ('_':))) lensRules) ''ManagerSettings)
$(makeLensesWith (set lensField (mappingNamer ((:[]) . ('_':))) lensRules) ''HistoriedResponse)
$(makeLensesWith (set lensField (mappingNamer ((:[]) . ('_':))) lensRules) ''Connection)

$(makePrisms ''HttpException)
$(makePrisms ''HttpExceptionContent)
