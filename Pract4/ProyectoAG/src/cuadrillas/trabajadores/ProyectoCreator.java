package cuadrillas.trabajadores;

import java.util.Random;
import org.opt4j.core.genotype.SelectGenotype;
import org.opt4j.core.problem.Creator;

public class ProyectoCreator implements Creator<SelectGenotype<JornadasSymbol>>
{
	public SelectGenotype<JornadasSymbol> create()
	  {
	    JornadasSymbol[] Symbols = {JornadasSymbol.ONE, JornadasSymbol.TWO, JornadasSymbol.THREE};
	    SelectGenotype<JornadasSymbol> genotype = new SelectGenotype<JornadasSymbol>(Symbols);
	    // el genotipo estara formado por "numeroSimbolos" de índice elegidos al azar
	    // en nuestro caso la poblacion sera un conjunto de individuos, donde cada individuo son 10 simbolos
	    genotype.init(new Random(), Datos.NUM_CUADRILLAS);
	    
	    return genotype;
	  }
}
