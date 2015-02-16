module Main where

import           Network.Wai.Handler.Warp
import           Rest.Driver.Wai
import           System.Environment

import           Constellation.Api
import           Constellation.Types

main :: IO ()
main = do
        port <- getEnv "CONSTELLATION_PORT"
        let env = Environment
            app = apiToApplication (runConstellation env) api
        run (read port) app
