package cuadrillas.trabajadores;

import java.util.ArrayList;
import org.opt4j.core.genotype.SelectGenotype;
import org.opt4j.core.problem.Decoder;

public class ProyectoDecoder implements Decoder<SelectGenotype<JornadasSymbol>, ArrayList<JornadasSymbol>>
{
	public ArrayList<JornadasSymbol> decode(SelectGenotype<JornadasSymbol> genotype)
	  {
	    ArrayList<JornadasSymbol> phenotype = new ArrayList<JornadasSymbol>();
	    // codigo para que el fenotipo cumpla restricciones
	    for (int i = 0; i < genotype.size(); i++)
	    {
	      phenotype.add(genotype.getValue(i));
	    }
	    return phenotype;
	  }
}
