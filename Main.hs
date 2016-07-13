{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

import qualified Data.Aeson as AE
import qualified Data.JsonStream.Parser as JS
import Data.Aeson.TH
import qualified Data.ByteString as B
import Control.Monad (replicateM_)
import Criterion.Main



main :: IO ()
main = defaultMain
    [ env (B.readFile "./twitter10.json") $ \ t -> bgroup "twitter10.json" (go t)
    , env (B.readFile "./twitter100.json") $ \ t -> bgroup "twitter100.json" (go t)
    ]

go :: B.ByteString -> [Benchmark]
go bs =
    [ bench "aeson parser"       $ nf (AE.decodeStrict :: B.ByteString -> Maybe AE.Value) bs
    , bench "json-stream parser" $ nf (JS.decodeStrict :: B.ByteString -> Maybe AE.Value) bs
    ]
