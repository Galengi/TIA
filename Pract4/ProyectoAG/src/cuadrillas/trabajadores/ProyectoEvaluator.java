package cuadrillas.trabajadores;

import java.util.ArrayList;
import org.opt4j.core.Objectives;
import org.opt4j.core.Objective.Sign;
import org.opt4j.core.problem.Evaluator;

public class ProyectoEvaluator implements Evaluator<ArrayList<JornadasSymbol>>
{
	public Objectives evaluate (ArrayList<JornadasSymbol> phenotype)
	  {
	  	int coste = 0;
	  	int produ = 0;
	  	int quantitat1 = 0;
	  	int quantitat2 = 0;
	  	int quantitat3 = 0;
	    	for (int i = 0; i < phenotype.size(); i++)
	    	{
	    		switch (phenotype.get(i))
	    		{
	    			case ONE: coste += Datos.matrizCostes[0][i];
						produ += Datos.matrizProductividad[0][i]; 
						quantitat1 ++; break;
	    			case TWO: coste += Datos.matrizCostes[1][i];
						produ += Datos.matrizProductividad[1][i];
						quantitat2 ++; break;
	    			case THREE: coste += Datos.matrizCostes[2][i];
						produ += Datos.matrizProductividad[2][i];
						quantitat3 ++; break;
	    		}
	    	}
	    	if (quantitat1 < 3 || quantitat2 < 3 || quantitat3 < 3)
	    	{
	    		coste = Integer.MAX_VALUE;
	    		produ = Integer.MIN_VALUE;
	    	}
	   	 Objectives objectives = new Objectives();
		 objectives.add("Valor objetivo-MAX", Sign.MAX, produ);
		 objectives.add("Valor objetivo-MIN", Sign.MIN, coste);
		 
		 return objectives;
	  }
}
