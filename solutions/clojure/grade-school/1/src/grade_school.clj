(ns grade-school)

(defn grade [school grade]
  (get school grade []))

(defn add [school name grade]
  (update school grade (fnil conj []) name))

(defn sorted [school]
  (->> school
       (map (fn [[grade students]] [grade (sort students)]))
       (into (sorted-map))))
