module Main where

import           Data.Maybe
import           Data.Time


main :: IO ()
main = loop samples
  where
    loop []          = return ()
    loop ((s,tod):t) = case parseTimeOfDay s of
      Nothing   -> error $ "failed to parse: " ++ s
      Just tod_ -> case tod==tod_ of
        True  -> do putStrLn $ "passed: " ++ show tod; loop t
        False -> error $ "parsed to wrong value: " ++show (tod,tod_)

time_templates ::[String]
time_templates = ["%H:%M:%S","%H:%M:%S%Q","%H:%M"]

parseTimeOfDay :: String -> Maybe TimeOfDay
parseTimeOfDay = parse_time time_templates

parse_time :: ParseTime t => [String] -> String -> Maybe t
parse_time tpls = prs
  where
    prs s = listToMaybe $ catMaybes
      [ parseTimeM False defaultTimeLocale fmt s
          | fmt<-tpls
          ]

samples :: [(String,TimeOfDay)]
samples =
    [ f "00:00:00"            00 00 0
    , f "23:59:59"            23 59 59000000000000
    , f "00:00:00.1234567890" 00 00 00123456789000
    ]
  where
    f s h m ps = (s,TimeOfDay h m $ toEnum ps)
