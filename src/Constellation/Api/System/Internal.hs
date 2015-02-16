{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}

module Constellation.Api.System.Internal where

import           Control.Monad.IO.Class
import           Data.Aeson.Types
import           Data.Data
import           Data.JSON.Schema
import           Data.Time
import           GHC.Generics
import           Rest
import qualified Rest.Resource          as R

import           Constellation.Types

data GetRes = GetRes
        { getresServerTime ::UTCTime
        } deriving (Show, Data, Typeable, Generic)

instance ToJSON GetRes where
    toJSON = genericToJSON defaultOptions { fieldLabelModifier = drop 6 }
instance JSONSchema GetRes where schema = gSchema

resource :: Resource Constellation Constellation () Void Void
resource = mkResourceId
        { R.name    = "system"
        , R.schema  = singleton () $ named []
        , R.get     = Just get
        }

get :: Handler Constellation
get = mkConstHandler (jsonO . someO) $ do
        now <- liftIO getCurrentTime
        return $ GetRes now
