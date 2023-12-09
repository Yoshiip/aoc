using System;
using System.IO;
using System.Collections.Generic;

class Part2
{
    static int ContainsPair(char card, string hand) {
        int count = 0;
        foreach (char c in hand) 
            if (c == card) count++;
        return count;
    }

    static int CountInPair(List<int> list, int element) {
        int count = 0;
        foreach (int s in list) {
            if (s == element) count++;
        }
        return count;
    }

    

    static int ComparePair(string pairA, string pairB) {
        string strength = "J23456789TQKA";
        for (int i = 0; i < pairA.Length; i++) {
            if(strength.IndexOf(pairA[i]) > strength.IndexOf(pairB[i])) {
                return 1;
            } else if(strength.IndexOf(pairA[i]) < strength.IndexOf(pairB[i])) {
                return -1;
            }
        }
        return 0;
    }


    static int TestHand(string hand) {
        var pairs = new Dictionary<char, int>();
        
        char maxcard = 'A';
        foreach (var card in hand)
        {
            if(card != 'J' && (maxcard == '/' || ContainsPair(card, hand) > ContainsPair(maxcard, hand))) {
                maxcard = card;
            }
        }
        
        for (int i = 0; i < hand.Length; i++)
        {
            if(hand[i] == 'J') {
                char[] ch = hand.ToCharArray();
                ch[i] = maxcard; // index starts at 0!
                hand = new string(ch);
            }
        }
        
        foreach (var card in hand)
        {
            pairs[card] = ContainsPair(card, hand);
        }


        if(CountInPair(pairs.Values.ToList(), 5) == 1) { // Five of a kind
            return 6;
        } else if(CountInPair(pairs.Values.ToList(), 4) == 1) { // Four of a kind
            return 5;
        } else if(CountInPair(pairs.Values.ToList(), 3) == 1 && CountInPair(pairs.Values.ToList(), 2) == 1) { // Full house
            return 4;
        } else if(CountInPair(pairs.Values.ToList(), 3) == 1) { // Three of a kind
            return 3;
        } else if(CountInPair(pairs.Values.ToList(), 2) == 2) { // Two pair
            return 2;
        } else if(CountInPair(pairs.Values.ToList(), 2 ) == 1) { // One pair
            return 1;
        }
        return 0; // High card
    }

    

    static void Main(string[] args) {
        List<string> hands = new List<string>();
        List<int> bids = new List<int>();
        List<int> ranking = new List<int>();
        using (StreamReader sr = File.OpenText("input.txt")) {
            string line;
            while ((line = sr.ReadLine()) != null)
            {
                hands.Add(line.Substring(0, 5));
                bids.Add(Int32.Parse(line.Substring(6)));
            }
        }
        for (int i = 0; i < hands.Count; i++) {
            if(ranking.Count == 0) {
                ranking.Add(i);
            } else {
                bool added = false;
                for (int j = 0; j < ranking.Count; j++) {
                    if(TestHand(hands[i]) > TestHand(hands[ranking[j]])) {
                        ranking.Insert(j, i);
                        added = true;
                        break;
                    } else if((TestHand(hands[i]) == TestHand(hands[ranking[j]])) && ComparePair(hands[i], hands[ranking[j]]) >= 0) {
                        ranking.Insert(j, i);
                        added = true;
                        break;
                    }
                }
                if(!added) {
                    ranking.Add(i);
                }
                
            }
        }
        int total = 0;

        for (int i = 0; i < ranking.Count; i++)
        {
            total += bids[ranking[i]] * (ranking.Count - i);
        }
        Console.WriteLine(total);
    }
}