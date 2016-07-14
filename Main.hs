{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

import qualified Data.Aeson.Parser as AE
import qualified Data.Attoparsec.ByteString as AT
import qualified Data.JsonStream.Parser as JS
import qualified Data.ByteString as B
import Control.Monad (replicateM_)
import Criterion.Main



main :: IO ()
main = defaultMain
    [ env (B.readFile "./escape.txt") $ \ t -> bgroup "escape.json" (go t)
    , env (B.readFile "./noescape.txt") $ \ t -> bgroup "noescape.json" (go t)
    ]

go :: B.ByteString -> [Benchmark]
go bs =
    [ bench "aeson parser"       $ nf (AT.parse AE.jstring) bs
    , bench "json-stream parser" $ nf (JS.parseByteString JS.string) bs
    ]
