object Bob:
  def response(statement: String): String =
    val trimmed = statement.trim
    val isQuestion = trimmed.endsWith("?")
    val isSilence = trimmed.isEmpty
    val isYelling = trimmed.exists(_.isLetter) &&
      trimmed.filter(_.isLetter).forall(_.isUpper)

    trimmed match {
      case _ if isSilence               => "Fine. Be that way!"
      case _ if isQuestion && isYelling => "Calm down, I know what I'm doing!"
      case _ if isYelling               => "Whoa, chill out!"
      case _ if isQuestion              => "Sure."
      case _                            => "Whatever."
    }
