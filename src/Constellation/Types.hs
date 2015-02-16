{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Constellation.Types where

import           Control.Applicative
import           Control.Monad.Base
import           Control.Monad.Error
import           Control.Monad.Logger
import           Control.Monad.Reader
import           Control.Monad.Trans.Resource

data Environment = Environment

newtype Constellation a = Constellation { unConstellation :: ResourceT (ReaderT Environment (LoggingT IO)) a }
    deriving ( Functor, Applicative, Monad, MonadIO, MonadThrow
             , MonadReader Environment
             , MonadBase IO
             , MonadResource
             )

runConstellation :: Environment -> Constellation a -> IO a
runConstellation env = runStdoutLoggingT . flip runReaderT env . runResourceT . unConstellation

class Monad m => MonadConstellation m where
