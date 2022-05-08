//Writing to a file
    try{
        FileOutputStream fos = openFileOutput("myname.txt", MODE_PRIVATE);
        String text = "hi";
        fos.write(test.getBytes());
        fos.close();
    }
    catch(Exception ex){
    }
    //write to a file called myname.txt on a folder called "files"


//Reading from a file
    try{
        FileInputStream fis = openFileInput("myfile.txt");
        BufferedReader b = new BufferedReader(new InputStreamReader(fis));
        //to read all lines
        /*
        String s = b.readLine();
        while (s != null){
            //processing
            s = b.readLine();
        }
        */
        Log.i("info", b.readLine()); //Write to logcat
        fis.close();
    }
    catch (Exception ex){
    }


//Shared preferences - think as key-value pairs
    //We can also use getPreferences(Context.MODE_PRIVATE) if we want to get a specific file to MainActivity (MainActivity.xml)
    SharedPreferences p = getSharePreferences("myprefs", Context.MODE_PRIVATE); // think shared preferences as pointer to the file
    SharedPreferences.Editor editor = p.edit();
    editor.putInt("mykey", 123); // the pair is "mykey", 123
    editor.apply();
    //the result is the key-value pair that appears in an XML file

//To get an integer value from a key
    int value = p.getInt("mykey", 0); //0 is the default value if the key is not found
    Log.i("info", "" + value);


//Writing to the realtime database
    DatabaseReference ref = FirebaseDatabase.getInstance().getReference();
    Student student = new Student(100, "alice");
    ref.child("students").child("s1").setValue(student);


//Reading from the realtime database
    DatabaseReference ref = FirebaseDatabase.getInstance().getReference("students");
    ValueEventListener listener = new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot datasnapshot){
            for (DataSnapshot child: datasnapshot.getChildren()){
                Student student = child.getValue(Student.class);
                Log.i("info", student.toString());
            }
        }

        @Override
        public void onCancelled (DatabaseError databaseError){
            Log.w("warning", "loadPost:onCancelled", databaseError.toException());
        }
    };
    ref.addValueEventListener(listener);

