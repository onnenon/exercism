(ns cars-assemble)

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (let [success-rate (cond
                       (= speed 10) 0.77
                       (= speed 9)  0.80
                       (>= speed 5) 0.90
                       (pos? speed) 1.00
                       :else        0.00)]
    (* speed 221 success-rate)))

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (-> speed
      production-rate
      (/ 60)
      int))
