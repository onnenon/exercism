object SpaceAge:
  enum Planet:
    case Mercury,
      Venus,
      Earth,
      Mars,
      Jupiter,
      Saturn,
      Uranus,
      Neptune

  def secondsToYears(age: Double): Double = age / 31_557_600

  def convertAge(age: Double, planet: Planet): Double =
    var conversionRate = planet match {
      case Planet.Mercury => 0.2408467
      case Planet.Venus   => 0.61519726
      case Planet.Earth   => 1.0
      case Planet.Mars    => 1.8808158
      case Planet.Jupiter => 11.862615
      case Planet.Saturn  => 29.447498
      case Planet.Uranus  => 84.016846
      case Planet.Neptune => 164.79132
    }
    secondsToYears(age) / conversionRate

  def onEarth(age: Double) = convertAge(age, Planet.Earth)
  def onMercury(age: Double) = convertAge(age, Planet.Mercury)
  def onVenus(age: Double) = convertAge(age, Planet.Venus)
  def onMars(age: Double) = convertAge(age, Planet.Mars)
  def onJupiter(age: Double) = convertAge(age, Planet.Jupiter)
  def onSaturn(age: Double) = convertAge(age, Planet.Saturn)
  def onUranus(age: Double) = convertAge(age, Planet.Uranus)
  def onNeptune(age: Double) = convertAge(age, Planet.Neptune)
