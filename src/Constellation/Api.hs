module Constellation.Api where

import           Rest.Api

import qualified Constellation.Api.System as System
import           Constellation.Types

api :: Api Constellation
api = [(mkVersion 1 0 0, Some1 constellation)]

constellation :: Router Constellation Constellation
constellation = root -/ route System.resource
