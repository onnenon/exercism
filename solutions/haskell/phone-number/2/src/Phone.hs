module Phone (number) where

import Data.Char (isNumber)

data PhoneNumber = PhoneNumber {areaCode :: String, exchangeCode :: String, subscriberNumber :: String} deriving (Show)

phoneNumberToString :: PhoneNumber -> String
phoneNumberToString pn = areaCode pn ++ exchangeCode pn ++ subscriberNumber pn

number :: String -> Maybe String
number xs = fmap phoneNumberToString (parsed >>= validAreaCode >>= validExchangeCode)
  where
    parsed = parseNumber xs

parseNumber :: String -> Maybe PhoneNumber
parseNumber xs =
  case normalized of
    [a1, a2, a3, e1, e2, e3, s1, s2, s3, s4] -> Just $ PhoneNumber [a1, a2, a3] [e1, e2, e3] [s1, s2, s3, s4]
    _ -> Nothing
  where
    digits = filter isNumber xs
    normalized = if length digits == 11 && head digits == '1' then tail digits else digits

validAreaCode :: PhoneNumber -> Maybe PhoneNumber
validAreaCode pn@PhoneNumber {areaCode = a : _}
  | a `elem` ['0', '1'] = Nothing
  | otherwise = Just pn
validAreaCode _ = Nothing

validExchangeCode :: PhoneNumber -> Maybe PhoneNumber
validExchangeCode pn@PhoneNumber {exchangeCode = e : _}
  | e `elem` ['0', '1'] = Nothing
  | otherwise = Just pn
validExchangeCode _ = Nothing