(ns grade-school)

(defn grade [school grade]
  (school grade []))

(defn add [school name grade]
  (assoc school grade (conj (school grade []) name)))

(defn sorted [school]
  (into (sorted-map) (for [[k v] school] [k (sort v)])))