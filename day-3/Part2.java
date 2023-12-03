import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class Part2 {
    public static int getNumber(char[][] engine, int baseX, int baseY) {
        boolean correctDigit = false;
        int start = -1, end = -1;
        for (int x = 0; x < engine[baseY].length; x++) {
            if(x == baseX) {
                correctDigit = true;
            }
            if(Character.isDigit(engine[baseY][x])) {
                if(start == -1) {
                    start = x;
                }
            } else if(!Character.isDigit(engine[baseY][x])) {
                if(start != -1) {
                    end = x;
                }
                if(correctDigit) {
                    return Integer.parseInt(new String(engine[baseY]).substring(start, end));
                } else {
                    start = -1;
                    end = -1;
                }
            }
        }
        if(Character.isDigit(engine[baseY][engine[0].length - 1]) && end == -1) {
            end = engine[0].length;
            return Integer.parseInt(new String(engine[baseY]).substring(start, end));
        }
        return 0;
    }

    public static int calculateGear(char[][] engine, int gearX, int gearY) {
        int digit1 = -1;
        int digit2 = -1;
        for (int sy = gearY - 1; sy < gearY + 2; sy++) {
            boolean foundDigit = false;
            for (int sx = gearX - 1; sx < gearX + 2; sx++) {
                if(sy < 0 || sy >= engine.length || sx < 0 || sx >= engine[0].length) {
                    continue;
                } else {
                    if(Character.isDigit(engine[sy][sx])) {
                        if(!foundDigit) {
                            foundDigit = true;
                            
                            if(digit1 == -1) {
                                digit1 = getNumber(engine, sx, sy);
                            } else if(digit2 == -1) {
                                digit2 = getNumber(engine, sx, sy);
                            }
                        }
                    } else {
                        foundDigit = false;
                    }
                }
            }
        }
        if(digit1 == -1 || digit2 == -1) {
            return 0;
        }
        return digit1 * digit2;
    }

    public static char[][] createCharMap(Object[] objects) {
        int xLength = ((String) objects[0]).length();
        char[][] map = new char[objects.length][xLength];
        for (int y = 0; y < objects.length; y++) {
            for (int x = 0; x < xLength; x++) {
                map[y][x] = ((String) objects[y]).charAt(x);
            }
        }
        return map;
    }

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader("input.txt"));
        Object[] object_engine = (Object[]) reader.lines().toArray();

        char[][] engine = createCharMap(object_engine);
        int sum = 0;

        
        for (int y = 0; y < engine.length; y++) {
            for (int x = 0; x < engine[0].length; x++) {
                if(engine[y][x] == '*') {
                    sum += calculateGear(engine, x, y);
                }
            }
        }
        reader.close();
        System.out.println(sum);
    }
}