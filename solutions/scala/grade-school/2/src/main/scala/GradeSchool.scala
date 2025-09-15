class School:
  type DB = Map[Int, Seq[String]]
  private var database: DB = Map()

  def add(name: String, g: Int) =
    val updatedGrade = (database.getOrElse(g, Seq()) :+ name).sorted
    database = database.updated(g, updatedGrade)

  def db: DB = database

  def grade(g: Int): Seq[String] = database.getOrElse(g, Seq())

  def sorted: DB = database
