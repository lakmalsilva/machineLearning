## Copyright (C) 2017 Lakmal Silva
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## neuralOR

## Author: lakmal <lakmal@yahoo.com>
## Created: 2017-05-14

function ret = neuralOR
  clear all
  clc

  #Initialization
  theta = 0;
  learning_rate = 0.01;
  input = [0 0 1 1 ; 0 1 0 1]';
  weights = [0.5 0.5 0.5 0.5 ; 0.1 0.1 0.1 0.1]';
  y_desired = [0 1 1 1]';
  stepOR = [1 1 1 1]';
  zero = [0 0 0 0]';
  loop = true;
  
  #Activation
  while loop
    temp = input .* weights;
    temp1 = temp(: ,1) + temp(: ,2) - theta;
    y_act = ge(temp1, stepOR);
    error = y_desired - y_act;
    
    if(eq(error, zero))
      loop = false;
    else  
      #Weight Training
      weights = weights + (learning_rate * input .* error);
    endif
  endwhile
  
  #Verification: 
  final_weights = weights
  neural_output = ge(temp1, stepOR)

endfunction
