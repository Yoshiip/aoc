import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class Part1 {
    public static int isValid(char[][] engine, int startX, int startY, int length) {
        boolean valid = false;
        for (int sy = startY - 1; sy < startY + 2; sy++) {
            for (int sx = startX - 1; sx < startX + length + 1; sx++) {
                if(sy < 0 || sy >= engine.length || sx < 0 || sx >= engine[0].length) {
                    continue;
                } else {
                    if(engine[sy][sx] != '.' && !Character.isDigit(engine[sy][sx])) {
                        valid = true;
                    }
                }
            }
        }
        if(!valid) return 0;
        return Integer.parseInt(new String(engine[startY]).substring(startX, startX + length));
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
            boolean insideNumber = false;
            int numberStartX = -1000;
            for (int x = 0; x < engine[0].length; x++) {
                if(Character.isDigit(engine[y][x])) {
                    if(!insideNumber) {
                        numberStartX = x;
                    }
                    insideNumber = true;
                } else {
                    if(insideNumber) {
                        sum += isValid(engine, numberStartX, y, x - numberStartX);
                        numberStartX = -1000;
                    }
                    insideNumber = false;
                }
            }
            if(insideNumber) {
                sum += isValid(engine, numberStartX, y, engine[y].length - numberStartX);
            }
        }
        reader.close();
        System.out.println(sum);
    }
}