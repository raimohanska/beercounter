{-# LANGUAGE OverloadedStrings #-}

module Server where

import           Snap.Http.Server
import           Snap.Core
import           BeerCounter

main :: IO ()
main = serve defaultConfig

serve :: Config Snap a -> IO()
serve config = httpServe config $ route [ 
  ("/buyRound", buyRound)
  ,("/karma/:me/:other", karma) ] 

