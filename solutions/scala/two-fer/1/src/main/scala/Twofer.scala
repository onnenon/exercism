object Twofer {
  def twofer(name: String): String = name match {
    case name if name.isEmpty() => s"One for you, one for me."
    case name                   => s"One for ${name}, one for me."
  }
}
