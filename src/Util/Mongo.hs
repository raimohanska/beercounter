module Util.Mongo where

import           Control.Monad
import           Control.Applicative
import           Data.Bson.Mapping
import           Database.MongoDB
import           Control.Monad.IO.Class

mongoPost :: Bson a => Database -> Collection -> a -> IO String
mongoPost db collection x = do val <- doMongo db $ insert collection $ toBson x 
                               case val of
                                  ObjId (oid) -> return $ show oid
                                  _           -> fail $ "unexpected id"

mongoFindOne :: Bson a => Database -> Query -> IO (Maybe a)
mongoFindOne db query = do
                 doc <- doMongo db $ findOne query
                 return (doc >>= (fromBson >=> Just))

mongoFindAll :: Bson a => Database -> Collection -> IO [a]
mongoFindAll db collection = mongoFind db (select [] collection)

mongoFind :: Bson a => Database -> Query -> IO [a]
mongoFind db query = do
                 docs <- doMongo db $ rest =<< find query
                 mapM fromBson docs

doMongo :: Database -> Action IO a -> IO a
doMongo db action = do
  pipe <- liftIO $ runIOE $ connect (host "127.0.0.1")
  result <- access pipe master db action
  liftIO $ close pipe
  case result of
    Right val -> return val 
    Left failure -> fail $ show failure
