module Phone (number) where

import Data.Char (isNumber)

data PhoneNumber = PhoneNumber {areaCode :: String, exchangeCode :: String, subscriberNumber :: String} deriving (Show)

phoneNumberToString :: PhoneNumber -> String
phoneNumberToString pn = areaCode pn ++ exchangeCode pn ++ subscriberNumber pn

number :: String -> Maybe String
number xs = fmap phoneNumberToString (pN >>= validAreaCode >>= validExchangeCode)
  where
    filteredNumber = filter isNumber xs
    pN = pNumber filteredNumber

pNumber :: String -> Maybe PhoneNumber
pNumber ['1', a1, a2, a3, e1, e2, e3, s1, s2, s3, s4] = Just PhoneNumber {areaCode = [a1, a2, a3], exchangeCode = [e1, e2, e3], subscriberNumber = [s1, s2, s3, s4]}
pNumber [a1, a2, a3, e1, e2, e3, s1, s2, s3, s4] = Just PhoneNumber {areaCode = [a1, a2, a3], exchangeCode = [e1, e2, e3], subscriberNumber = [s1, s2, s3, s4]}
pNumber _ = Nothing

validAreaCode :: PhoneNumber -> Maybe PhoneNumber
validAreaCode pn
  | head (areaCode pn) `elem` ['0', '1'] = Nothing
  | otherwise = Just pn

validExchangeCode :: PhoneNumber -> Maybe PhoneNumber
validExchangeCode pn
  | head (exchangeCode pn) `elem` ['0', '1'] = Nothing
  | otherwise = Just pn