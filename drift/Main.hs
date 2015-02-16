{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module Main where

import qualified Data.ByteString.Char8      as Char
import           Data.FileEmbed
import           Database.PostgreSQL.Simple
import           Drifter.PostgreSQL
import           Drifter.Types
import           System.Environment

main :: IO ()
main = do
        connStr <- getEnv "CONSTELLATION_DB"
        conn    <- connectPostgreSQL (Char.pack connStr)
        res     <- migrate (DBConnection conn) changes
        case res of
            Left  er -> putStrLn er
            Right () -> putStrLn "Migration Complete"

changes :: [Change Postgres]
changes =
        [ Change "schema-constellation" Nothing (Script $(embedFile "drift/schema/constellation.sql"))
        ]
