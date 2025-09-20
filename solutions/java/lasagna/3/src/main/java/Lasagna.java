public class Lasagna {
    private static final int EXPECTED_MINUTES_IN_OVEN = 40;
    private static final int PREPARATION_TIME_PER_LAYER = 2;

    public int expectedMinutesInOven() {
        return EXPECTED_MINUTES_IN_OVEN;
    }

    public int remainingMinutesInOven(int bakeTime) {
        return expectedMinutesInOven() - bakeTime;
    }

    public int preparationTimeInMinutes(int layers) {
        return PREPARATION_TIME_PER_LAYER * layers;
    }

    public int totalTimeInMinutes(int layers, int actualMinutes) {
        return preparationTimeInMinutes(layers) + actualMinutes;
    }
}