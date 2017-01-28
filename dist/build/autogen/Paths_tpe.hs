module Paths_tpe (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,0,0,1] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/chris/.cabal/bin"
libdir     = "/home/chris/.hubrc/heap/2940/x86_64-linux-ghc-7.8.4/tpe-0.0.0.1"
datadir    = "/home/chris/.cabal/share/x86_64-linux-ghc-7.8.4/tpe-0.0.0.1"
libexecdir = "/home/chris/.cabal/libexec"
sysconfdir = "/home/chris/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "tpe_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "tpe_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "tpe_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tpe_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tpe_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
