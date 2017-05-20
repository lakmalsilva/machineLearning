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

## neuralKmeans

## Author: lakmal <lakmal@yahoo.com>
## Created: 2017-05-14

function ret = neuralKmeans
  clear all
  clc

    #Initialization
    K = 2;
    imageA = [154 157 157 157 150 150 170 170 175 190 ;
  154 157 157 151 153 155 180 180 170 190 ;
  154 157 150 154 160 160 160 155 155 165 ;
  157 157 148 148 148 160 150 155 155 165 ;
  100 102 104 157 142 180 170 165 10 20 ; 
  100 103 105 165 155 180 175 162 40 50 ;
  100 102 108 132 180 180 172 167 25 63 ;
  18 28 48 12 13 20 5 15 30 40 ;
  15 36 46 18 21 22 28 32 30 36 ;
  17 21 24 26 35 45 28 30 40 20 ];

    imageB = [152 156 157 156 149 150 170 160 175 190 ;
  154 159 157 151 153 155 180 180 170 190 ;
  153 157 155 154 160 160 160 155 155 165 ;
  157 157 148 148 148 160 150 155 155 165 ;
  101 102 104 159 143 180 170 165 110 220 ;
  99 103 105 164 155 179 175 162 240 250 ;
  100 102 108 132 180 180 172 167 155 163 ;
  118 123 148 129 109 120 155 215 140 180 ;
  156 136 210 218 175 122 128 232 180 156 ;
  178 231 245 226 215 145 188 230 170 140];
  
  diffImage = abs(imageA - imageB)
  new_image = diffImage;
  
  column_size = columns(diffImage);
  raw_size = rows(diffImage);
  
  centroid1=diffImage(1,1);
  centroid2=diffImage(1,10);
  c1x=[];
  c1y=[];
  
  c2x=[];
  c2y=[];

  #Consider the difference of pixel values as the distance between points. 
  cont = true;
  while cont
    c1=0;
    c2=0;
    count1=0;
    count2=0;
    for i = 1:column_size
      for j = 1:raw_size
        centroid1_diff = abs(centroid1 - diffImage(i,j));
        centroid2_diff = abs(centroid2 - diffImage(i,j));
        if(centroid1_diff < centroid2_diff)
          c1x=[c1x i];
          c1y=[c1y j];    
          c1=c1 + diffImage(i,j);
          count1= count1 + 1;
          new_image(i,j)=0;
        else 
          c2x = [c1x i];
          c2y = [c1y j];   
          c2 = c2 + diffImage(i,j);
          count2= count2 + 1;
          new_image(i,j)=1;
        endif
      endfor
    endfor
    
    centroid1 = [sum(c1x)/columns(c1x) sum(c1y)/columns(c1y)]
    centroid2 = [sum(c2x)/columns(c2x) sum(c2y)/columns(c2y)]
    new_image
    c1/count2
    c2/count2
    
    
    #cont = false;
    
  endwhile

endfunction
