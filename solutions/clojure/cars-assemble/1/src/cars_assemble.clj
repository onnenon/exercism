(ns cars-assemble)

;; (defn production-rate
;;   "Returns the assembly line's production rate per hour,
;;    taking into account its success rate"
;;   [speed]
;;   (letfn [(r [x] (* speed 221 x))]
;;     (cond
;;       (= speed  10) (r 0.77)
;;       (= speed 9) (r 0.8)
;;       (> speed 4) (r 0.9)
;;       (> speed 0) (r 1.0)
;;       :else (r 0.0))))
(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (let [success-rate (cond
                       (= speed 10) 0.77
                       (= speed 9) 0.80
                       (> speed 4) 0.90
                       (> speed 0) 1.00
                       :else 0.00)]
    (* speed 221 success-rate)))

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (int (/ (production-rate speed) 60)))
