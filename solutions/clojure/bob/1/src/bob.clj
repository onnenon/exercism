(ns bob
  (:require [clojure.string :as str]))

(defn response-for [s]
  (let [trimmed (str/trim s)
        is-question (str/ends-with? trimmed "?")
        is-silence (str/blank? trimmed)
        has-letters (some Character/isLetter trimmed)
        is-yelling (and has-letters (= (str/upper-case trimmed) trimmed))]
    (cond
      is-silence "Fine. Be that way!"
      (and is-yelling is-question) "Calm down, I know what I'm doing!"
      is-yelling "Whoa, chill out!"
      is-question "Sure."
      :else "Whatever.")))
