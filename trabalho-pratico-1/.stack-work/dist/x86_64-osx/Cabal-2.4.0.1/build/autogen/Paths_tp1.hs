{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_tp1 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/flavianunes/Documents/Ufop/learning-haskell/trabalho-pratico-1/.stack-work/install/x86_64-osx/250ba4ee074de76ad740c835567d444c99eadac216c75a798597ee874ef1087b/8.6.5/bin"
libdir     = "/Users/flavianunes/Documents/Ufop/learning-haskell/trabalho-pratico-1/.stack-work/install/x86_64-osx/250ba4ee074de76ad740c835567d444c99eadac216c75a798597ee874ef1087b/8.6.5/lib/x86_64-osx-ghc-8.6.5/tp1-0.1.0.0-80RAEAG4FHW8SHsZ8OpWQ0"
dynlibdir  = "/Users/flavianunes/Documents/Ufop/learning-haskell/trabalho-pratico-1/.stack-work/install/x86_64-osx/250ba4ee074de76ad740c835567d444c99eadac216c75a798597ee874ef1087b/8.6.5/lib/x86_64-osx-ghc-8.6.5"
datadir    = "/Users/flavianunes/Documents/Ufop/learning-haskell/trabalho-pratico-1/.stack-work/install/x86_64-osx/250ba4ee074de76ad740c835567d444c99eadac216c75a798597ee874ef1087b/8.6.5/share/x86_64-osx-ghc-8.6.5/tp1-0.1.0.0"
libexecdir = "/Users/flavianunes/Documents/Ufop/learning-haskell/trabalho-pratico-1/.stack-work/install/x86_64-osx/250ba4ee074de76ad740c835567d444c99eadac216c75a798597ee874ef1087b/8.6.5/libexec/x86_64-osx-ghc-8.6.5/tp1-0.1.0.0"
sysconfdir = "/Users/flavianunes/Documents/Ufop/learning-haskell/trabalho-pratico-1/.stack-work/install/x86_64-osx/250ba4ee074de76ad740c835567d444c99eadac216c75a798597ee874ef1087b/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "tp1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "tp1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "tp1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "tp1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tp1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tp1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
