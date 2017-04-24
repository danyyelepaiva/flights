/**
 * Created by ricardo on 4/20/17.
 */
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Scanner;

class Node{
    String Origem;
    String Destino;
    String Voo;
    String Hpartida;
    String Hchegada;
    String Nvoo;
    String Dias;

    Node() {
        Origem = "";
        Destino = "";
        Voo = "";
        Hpartida = "";
        Hchegada = "";
        Nvoo = "";
        Dias = "";
    }
}

public class Flights {
    public static String VooDireto(String Or, String De){
        for(int i = 0;i<lfinal.size();i++){
            Node no = lfinal.get(i);
            if (no.Origem.equals(Or) && no.Destino.equals(De)) return no.Voo;
        }
        return "Não existe";
    }

    public static String VooIndireto(String Or, String De){
        for(int i = 0; i < lfinal.size(); i++){
            Node no =  lfinal.get(i);
            String intermedio = no.Origem;
            if(!VooDireto(Or,intermedio).equals("Não existe") && !VooDireto(intermedio,De).equals("Não existe"))
                return (Or + " " + intermedio + " " + De);
        }
        return "Não existe";
    }

    // public static String trajecto(String Or, String DeA, String DeB, String DeC) {

    // }

    public static void dados(String str){
        Node no = new Node();
        int i = 10;
        int j = str.indexOf(",");
        no.Origem = str.substring(i,j);
        str = str.substring(j+1);
        j = str.indexOf(",");
        no.Destino = str.substring(0,j);
        str = str.substring(j+1);
        i = str.indexOf("[");
        j = str.indexOf("]") + 1;
        no.Voo = str.substring(i,j);
        //System.out.print("Origem ");System.out.println(no.Origem);
        //System.out.print("Destino ");System.out.println(no.Destino);
        //System.out.print("Voos ");System.out.println(str.substring(i,j));
        lfinal.add(no);
    }

    public static void InsereVoos(String str){
        str = str.replace(" ","");
        str = str.replace("\n","");
        str = str.replace("\t","");
        while((str.indexOf('.'))!=-1){
            int i = str.indexOf('.') + 1;
            dados(str.substring(0,i));
            lista.add(str.substring(0,i));
            str=str.substring(i);
        }
    }

    public static String LeInput(){
        final String FILENAME = "rotas.txt";
        String str = "";
        String aux = "";

            try (BufferedReader br = new BufferedReader(new FileReader(FILENAME))) {

                String sCurrentLine;

                while ((sCurrentLine = br.readLine()) != null) {
                    str += aux;
                    aux = sCurrentLine;
                }
                return str += aux;

            } catch (IOException e) {
                e.printStackTrace();
            }
        return str;
    }

    public static void ImprimeLista(){
        while(lista.size()>0){
            System.out.println(lista.poll());
        }
    }
    public static LinkedList<String> lista = new LinkedList<String>();
    public static LinkedList<Node> lfinal = new LinkedList<Node>();

    public static void main(String[] args)throws java.io.IOException  {
        Scanner in = new Scanner(System.in);
        String str = LeInput();
        InsereVoos(str);
        System.out.println("Indique entre que cidades pretende voar!\n" + "Origem: ");
        String origem = in.next();
        System.out.println("Destino: ");
        String destino = in.next();
        System.out.println("Dias dos voos diretos entre " + origem.toUpperCase() + " para " + destino.toUpperCase());
        System.out.println(VooDireto(origem,destino));
        System.out.println("Chegar de " + origem + " a " + destino);
        System.out.println(VooIndireto(origem,destino));
        //System.out.println(VooDireto("milan","london"));
        //System.out.println(VooDireto("london","edinbuh"));
    }
}
