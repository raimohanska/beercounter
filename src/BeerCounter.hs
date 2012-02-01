{-# LANGUAGE DeriveDataTypeable, TemplateHaskell, OverloadedStrings #-}

module BeerCounter where

import           Snap.Core
import           Data.Typeable
import           Data.Data
import           Data.Aeson.Generic as JSON
import           Util.HttpUtil
import           Util.Rest
import           Util.Json
import           Data.Bson.Mapping
import           Database.MongoDB
import           Control.Monad.IO.Class
import           Util.Mongo
import qualified Data.ByteString.Lazy.UTF8 as UTF8

type User = String
data Round = Round { buyer :: User, others :: [User] } deriving (Data, Typeable, Show, Eq)
$(deriveBson ''Round)

beerDB = "beer"
roundCollection = "round"

buyRound = method POST $ catchError "Internal Error" $ do 
    round <- readBodyJson :: Snap Round
    liftIO $ putStrLn $ "Round bought: " ++ (show round)
    objectId <- liftIO $ mongoPost beerDB roundCollection round
    writeLBS $ JSON.encode $ objectId 

karma = method GET $ catchError "Internal Error" $ do
    me <- requiredParam "me"
    other <- requiredParam "other"
    writeLBS $ UTF8.fromString $ "lol!"
