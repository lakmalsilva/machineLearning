function decision = ns_algorithm_final
  
	[self_sample1, sample_no_of_columns, sample_no_of_rows, patients, symptoms, mean1] = cal_affinity('my_patients_kl1');    
	printf("Class 1 mean: ");
	mean1
	detector1 = get_detectors(sample_no_of_columns, sample_no_of_rows, self_sample1, mean1);
	printf("Class 1 non self detectors \n");
	detector1

	[self_sample2, sample_no_of_columns, sample_no_of_rows, patients, symptoms, mean2] = cal_affinity('my_patients_kl2');
	printf("Class 2 mean: ");
	mean2
	detector2 = get_detectors(sample_no_of_columns, sample_no_of_rows, self_sample2, mean2);
	printf("Class 2 non self detectors \n");
	detector2

	[self_sample3, sample_no_of_columns, sample_no_of_rows, patients, symptoms, mean3] = cal_affinity('my_patients_kl3');
	printf("Class 3 mean: ");
	mean3
	detector3 = get_detectors(sample_no_of_columns, sample_no_of_rows, self_sample3, mean3);
	printf("Class 3 non self detectors \n");
	detector3
	
	continueprocess = true;
	while (continueprocess)
		decision_vec = input ("Enter vector for decision: ");
		is_it_non_self1 = make_decision(decision_vec, detector1, mean1);
    if(is_it_non_self1 == 0)
      printf("vector belongs to Class1! \n");
      rough_membership1 = membership_calc(decision_vec, self_sample1, mean1);
      printf("with group membership in class 1 : \n");
      rough_membership1
    else
      printf("test if vector belongs to Class2! \n");
      is_it_non_self2 = make_decision(decision_vec, detector2, mean2);
      if(is_it_non_self2 == 0)
          printf("vector belongs to Class2! \n");
          rough_membership2 = membership_calc(decision_vec, self_sample2, mean2);
          printf("with group membership in class 2 : \n");
          rough_membership2         
      else
          printf("test if vector belongs to Class3! \n");
          is_it_non_self3 = make_decision(decision_vec, detector3, mean3);
          if(is_it_non_self3 == 0)
              printf("vector belongs to Class3! \n");
              rough_membership3 = membership_calc(decision_vec, self_sample3, mean3);
              printf("with group membership in class 3 : \n");
              rough_membership3
          else
              printf("vector is NOT in any of the classses of interest \n");
          endif
      endif    
    endif 
		continueprocess  = input ("Finished decision making? (true/false): ");
	endwhile	
endfunction


function detectors = get_detectors(sample_no_of_columns, sample_no_of_rows, self_sample, mymean)
	detectors = 0;
	continueprocess = true;
	#no_of_detects_needed = input ("number of detectors to be found : ");

	A1 = 1; B1 = 4;
	A2 = 1; B2 = 2;
	A4 = 1; B4 = 6;
	A7 = 1; B7 = 5;

	#for det_count = 1:no_of_detects_needed
	while (continueprocess)
		candidate = [(floor((A1-1) + (B1-(A1-1))*rand(1)) + 1), (floor((A2-1) + (B2-(A2-1))*rand(1)) + 1), (floor((A2-1) + (B2-(A2-1))*rand(1)) + 1), (floor((A4-1) + (B4-(A4-1))*rand(1)) + 1), (floor((A4-1) + (B4-(A4-1))*rand(1)) + 1), (floor((A1-1) + (B1-(A1-1))*rand(1)) + 1), (floor((A7-1) + (B7-(A7-1))*rand(1)) + 1) ];

		if (columns(candidate) != sample_no_of_columns )
			printf("wrong vector size of detector candidate \n");
			continueprocess  = input ("Try another detector?(true/false): ");
		else
			detector_match = 0;
			for i = 1:sample_no_of_rows
				bitmatch = 0;
				for j = 1:sample_no_of_columns
					if(isequal(candidate(1,j),self_sample(i,j)))
						bitmatch++;
					endif
					j++;
				endfor
				aff = 0;
				aff = bitmatch/sample_no_of_columns;
				temp2 = 1-aff;
				if (temp2 < mymean)
					#printf("NOT a class 2 non self detector \n");
					1-aff;
				else
					#printf("matched as a non self detector for class 2 \n");
					detector_match++;
				endif     
				i++;  
			endfor
			if(detector_match == sample_no_of_rows)
				if (detectors==0)
					detectors = candidate;
				else
					detectors = [ detectors; candidate ];
				endif
				printf("vector is a detector of non-self \n");
			else
				printf("vector is NOT a detector of non-self \n");
			endif
			continueprocess = input ("Enough non self detectors? (true/false): ");
		endif
	endwhile
endfunction

function is_non_self = make_decision(decision_vec, detectors, mymean1)
	detector_no_of_columns = columns(detectors);
	detector_no_of_rows = rows(detectors);
  self_counter=0;
  nonself_counter=0;

		if (columns(decision_vec) != detector_no_of_columns )
			printf("wrong vector size of decision vector \n");
		else
			for i = 1:detector_no_of_rows
				bitmatch1 = 0;
				for j = 1:detector_no_of_columns
					if(isequal(decision_vec(1,j),detectors(i,j)))
						bitmatch1++;
					endif
					j++;
				endfor
				
        #printf("affinity is: \n");
        aff = 0;
				aff = bitmatch1/detector_no_of_columns;
        temp1 = 1-aff
				
				if (temp1 < mymean1)
				  #printf("vector is non-self in the class and doesn't belong to the class \n");
          printf("non-self \n");
          nonself_counter++;
          is_non_self = 1;
				else
				  #printf("vector is self in the class and belongs to the class \n");
          self_counter++;
          printf("self \n");
          is_non_self = 0;
          return;
				endif 
				i++; 
			endfor
		endif
endfunction

function rough_membership = membership_calc(decision_vec, self_sample9, mymean9)
	sample_no_of_columns = columns(self_sample9);
	sample_no_of_rows = rows(self_sample9);
  self_counter1 = 0;
  non_self_counter1 = 0;  

		if (columns(decision_vec) != sample_no_of_columns )
			printf("wrong vector size of decision vector \n");
		else
			for i = 1:sample_no_of_rows
				bitmatch = 0;
				for j = 1:sample_no_of_columns
					if(isequal(decision_vec(1,j),self_sample9(i,j)))
						bitmatch++;
					endif
					j++;
				endfor
				
        #printf("affinity is: \n");
        aff = 0;
				aff = bitmatch/sample_no_of_columns;
        mymean9
				temp3 = 1-aff
				if ( temp3 < mymean9 )
				  #printf("vector is self \n");
          self_counter1++;
				else
				  #printf("vector is non-self\n");
          non_self_counter1++;
				endif 
				i++; 
			endfor
      self_counter1
      non_self_counter1
      rough_membership = self_counter1/sample_no_of_rows
		endif
endfunction

function [self_sample, sample_no_of_columns, sample_no_of_rows, patients, symptoms, mymean] = cal_affinity(filename)
	self_sample = rot90(dlmread(filename));
	sample_no_of_columns = columns(self_sample);
	sample_no_of_rows = rows(self_sample);

	M = dlmread(filename);
	patients = columns(M);
	symptoms = rows(M);

	k=sum(M,2);

	S = dlmread('symptoms.data');
	j = sum(S, 2) * 10;
	affinity = k ./ j;

	mymean=mean(affinity);
endfunction