public class Button {
    String name;
    double value;
    boolean isDecreasing;
    boolean isDecreasingFast;
    boolean isIncreasing;
    boolean isIncreasingFast;

    public Button(String name, double value) {
        this.name = name;
        this.value = value;
        isDecreasing = false;
        isIncreasing = false;
    }

    public void updateValue() {
        if (isDecreasing) value *= 0.99;
        if (isDecreasingFast) value *= 0.9;
        if (isIncreasing) value *= 1.01;
        if (isIncreasingFast) value *= 1.1;

        if (value > 1) value = 1;
        if (value < 0) value = 0;
    }
}
