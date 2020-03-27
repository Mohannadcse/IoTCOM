package archExtractor;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import org.javatuples.Pair;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class ParseIFTTT {
	private HashSet<String> capabilities; 
	
	public ParseIFTTT() {
		capabilities = new HashSet<>();
	}

	public HashSet<String> getCapabilities() {
		return capabilities;
	}

	public static void main(String[] args) throws FileNotFoundException, IOException, ParseException {
		getSmartThingIftttRules();
		//getTriggerAction();
	}

	//This method was used to extract IFTTT rules that contain only ST trigger and action
	//the extracted lines will be stored as JSON objects in onlyST.json
	public static void getSmartThingIftttRules() throws FileNotFoundException, IOException, ParseException {
		ArrayList<JSONObject> json=new ArrayList<JSONObject>();
		HashSet<String> lines = new HashSet<String>();
	    JSONObject obj;
	    String fileName = "/Users/think/Downloads/SmartThings/IFTTT/201705/smartThingRecipes.json";
	    String onlyST = "/Users/think/Downloads/SmartThings/IFTTT/201705/onlyST.json";
	    String line = null;

	    try {
	        // FileReader reads text files in the default encoding.
	        FileReader fileReader = new FileReader(fileName);

	        // Always wrap FileReader in BufferedReader.
	        BufferedReader bufferedReader = new BufferedReader(fileReader);
	        BufferedWriter writer = new BufferedWriter(new FileWriter(onlyST, true));
	        int c = 0;
	        while((line = bufferedReader.readLine()) != null) {
	            obj = (JSONObject) new JSONParser().parse(line);
	            json.add(obj);
	            //System.out.println((String)obj.get("triggerChannelTitle")+":"+ (String)obj.get("triggerChannelId"));
	            if (Integer.parseInt((String)obj.get("triggerChannelId")) == 82 && Integer.parseInt((String)obj.get("actionChannelId")) == 82) {
	            	System.out.println("Counter:: "+ c++);
	            	//writer.append(line+"\n");
	            	lines.add(line+"\n");
	            }
	        }
	        // Always close files.
	        bufferedReader.close();  
	        
	        for (String l : lines) {
	        	writer.append(l);
	        }
	        writer.close();
	    }
	    catch(FileNotFoundException ex) {
	        System.out.println("Unable to open file '" + fileName + "'");                
	    }
	    catch(IOException ex) {
	        System.out.println("Error reading file '" + fileName + "'");                  
	        // Or we could just do this: 
	        // ex.printStackTrace();
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	}
	
	//triggerTitle, actionTitle
	public HashMap<String, Pair<List<String>, List<String>>> generateIFTTT_Rules() throws FileNotFoundException, IOException, ParseException {
		ArrayList<JSONObject> json=new ArrayList<JSONObject>();
	    JSONObject obj;
	    String onlyST = "/Users/think/Downloads/SmartThings/IFTTT/201705/onlyST.json";
	    String line = null;
//	    List<Pair<List<String>, List<String>>> rules = new ArrayList<>();
//	    List<HashMap<String, Pair<List<String>, List<String>>>> rules = new ArrayList<>();
	    HashMap<String, Pair<List<String>, List<String>> > rules = new HashMap<>();
	    try {
	        // FileReader reads text files in the default encoding.
	        FileReader fileReader = new FileReader(onlyST);

	        // Always wrap FileReader in BufferedReader.
	        BufferedReader bufferedReader = new BufferedReader(fileReader);
	        int c = 1;
	        HashSet<String> words = new HashSet<>();
	        HashSet<String> trigStmts = new HashSet<>();
	        HashSet<String> actionStmts = new HashSet<>();
	        List<String> action = new ArrayList<>();
	        List<String> trig = new ArrayList<>();
	        
	        while((line = bufferedReader.readLine()) != null) {
	            obj = (JSONObject) new JSONParser().parse(line);
	            json.add(obj);
	            System.out.println(c++ +"_ "+(String)obj.get("triggerTitle")+" : "+ (String)obj.get("actionTitle")
	            			+ " : "+ obj.get("url").toString().substring(obj.get("url").toString().indexOf("p-")+2));
	            
	            //generate the tuple
	            trig = resolveTrig((String)obj.get("triggerTitle"));
	            action = resolveAction((String)obj.get("actionTitle"));
	            
	            Pair<List<String>, List<String>> rule = new Pair<List<String>, List<String>>(trig, action);
	           
//	            hm.put(obj.get("url").toString().substring(obj.get("url").toString().indexOf("p-")+2), rule);
	            rules.put(obj.get("url").toString().substring(obj.get("url").toString().indexOf("p-")+2), rule);
	            
	            trigStmts.add((String)obj.get("triggerTitle"));
	            actionStmts.add((String)obj.get("actionTitle"));
	            String[] trigWords = obj.get("triggerTitle").toString().split(" ");
	            String[] actWords = obj.get("actionTitle").toString().split(" ");
	            for (String word : trigWords) {
	            	words.add(word);
	            }
	            
	            for (String word : actWords) {
	            	words.add(word);
	            }
	        }
	        //close the file.
	        bufferedReader.close(); 
	        
//	        System.out.println("WordsSetSize:: "+ words.size());
//	        System.out.println("WordsSet: "+words);
//	        System.out.println("TrigStmts:: "+ trigStmts.size());
//	        System.out.println("TrigSet:: "+ trigStmts);
//	        System.out.println("ActionStmts:: "+ actionStmts.size());
//	        System.out.println("ActionStmts:: "+ actionStmts);
	        /*
	        System.out.println("Parsing Action Stmts: ");
	        for (String action : actionStmts) {
	        	System.out.println(action);
	        	resolveAction(action);
	        }
	        
	        System.out.println("Parsing Trigger Stmts: ");
	        for (String trig : trigStmts) {
	        	System.out.println(trig);
	        	resolveTrig(trig);
	        }
	        */
	    }
	    catch(FileNotFoundException ex) {
	        System.out.println("Unable to open file '" + onlyST + "'");                
	    }
	    catch(IOException ex) {
	        System.out.println("Error reading file '" + onlyST + "'");                  
	        // Or we could just do this: 
	        // ex.printStackTrace();
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    return rules;
	}
	
	List<String> resolveAction(String stmt) {
		String cap = null, attr = null, val = null;
		List<String> actionTuple = new ArrayList<>();
		if (stmt.toLowerCase().contains("on")) {
			cap = "switch";
			attr = "switch";
			val = "on";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("off")) {
			cap = "switch";
			attr = "switch";
			val = "off";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("siren")) {
			cap = "alarm";
			attr = "alarm";
			val = "siren";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		}else if (stmt.toLowerCase().contains("unlock")) {
			cap = "lock";
			attr = "lock";
			val = "unlock";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("lock")) {
			cap = "lock";
			attr = "lock";
			val = "lock";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		}
		actionTuple.add(cap);
		actionTuple.add(attr);
		actionTuple.add(val);
		capabilities.add(cap);
		return actionTuple;
	}
	
	List<String> resolveTrig(String stmt) {
		String cap = null, attr = null, val = null;
		List<String> trigTuple = new ArrayList<>();
		if (stmt.toLowerCase().contains("motion")) {
			cap = "motionSensor";
			attr = "motion";
			val = "active";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("presence") && stmt.toLowerCase().contains("no")) {
			cap = "presenceSensor";
			attr = "presence";
			val = "not_present";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("on")) {
			cap = "switch";
			attr = "switch";
			val = "on";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("off")) {
			cap = "switch";
			attr = "switch";
			val = "off";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("opened")) {
			cap = "doorControl";
			attr = "door";
			val = "open";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("presence")) {
			cap = "presenceSensor";
			attr = "presence";
			val = "present";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("moisture")) {
			cap = "waterSensor";
			attr = "water";
			val = "wet";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("unlocked")) {
			cap = "lock";
			attr = "lock";
			val = "unlocked";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("locked")) {
			cap = "lock";
			attr = "lock";
			val = "locked";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("temperature") && stmt.toLowerCase().contains("below")) {
			cap = "temperatureMeasurement";
			attr = "temperature";
			val = "range_0";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		}  else if (stmt.toLowerCase().contains("temperature") && stmt.toLowerCase().contains("above")) {
			cap = "temperatureMeasurement";
			attr = "temperature";
			val = "range_1";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("brightness") && stmt.toLowerCase().contains("below")) {
			cap = "illuminanceMeasurement";
			attr = "illuminance";
			val = "range_0";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("brightness") && stmt.toLowerCase().contains("above")) {
			cap = "illuminanceMeasurement";
			attr = "illuminance";
			val = "range_1";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		} else if (stmt.toLowerCase().contains("closed")) {
			cap = "contactSensor";
			attr = "contact";
			val = "closed";
//			System.out.println("\tCap_"+cap+"_attr_"+attr+"_val:"+val);
		}
		trigTuple.add(cap);
		trigTuple.add(attr);
		trigTuple.add(val);
		capabilities.add(cap);
		return trigTuple;
	}
}
