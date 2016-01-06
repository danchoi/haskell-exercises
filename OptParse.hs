module Main where
import Options.Applicative
import Control.Applicative

data Options = Options { 
    showVersion :: Bool
  } deriving Show

parseOpts :: Parser Options
parseOpts = Options 
    <$> switch  (long "version" <> short 'v' <> help "Show version number")

opts = info (helper <*> parseOpts)
          (fullDesc 
            <> progDesc "Version flag example"
            <> header "show-version-example"
            )


main = do
    o <- execParser opts
    if (showVersion o)
    then putStrLn "Version: 10.1"
    else return ()
