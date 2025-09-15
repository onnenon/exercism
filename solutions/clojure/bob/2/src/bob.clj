(ns bob
  (:require [clojure.string :as str]))

(def silence? str/blank?)
(def question? #(str/ends-with? % "?"))
(def contains-letters? #(re-find #"[A-Za-z]" %))
(def all-uppercase? #(= % (str/upper-case %)))
(def yelling? (every-pred contains-letters? all-uppercase?))
(def yelling-question? (every-pred yelling? question?))

(defn response-for [s]
  (condp apply [(str/trim s)]
    silence? "Fine. Be that way!"
    yelling-question? "Calm down, I know what I'm doing!"
    yelling? "Whoa, chill out!"
    question?  "Sure."
    "Whatever."))