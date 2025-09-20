public class Lasagna {
    public int expectedMinutesInOven() {
        return 40;
    }

    public int remainingMinutesInOven(int bakeTime) {
        return expectedMinutesInOven() - bakeTime;
    }

    public int preparationTimeInMinutes(int layers) {
        return layers * 2;
    }

    public int totalTimeInMinutes(int layers, int actualMinutes) {
        return preparationTimeInMinutes(layers) + actualMinutes;
    }
}