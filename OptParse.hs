module Main where
import Options.Applicative
import Control.Applicative


data Options = Options { 
    username :: String
  } deriving Show



parseOpts :: Parser Options
parseOpts = Options 
    <$> (infoOption "Version 10.0" (short 'v' <> long "version")
        <*> strOption (short 'u' <> metavar "USERNAME"))

opts = info (helper <*> parseOpts)
          (fullDesc 
            <> progDesc "Version flag example"
            <> header "show-version-example"
            )


main = do
    o <- execParser opts
    print o
