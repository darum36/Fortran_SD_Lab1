module Process

   use Environment
   use Config

   implicit none

contains

   recursive function Find_First_Recursive(Current_First, Stud_To_Check) result(First)
           
         type(student), pointer, intent(in) :: Current_First, Stud_To_Check
         
         type(student), pointer             :: First
        
         if (Allocated(Stud_To_Check)) then

           if (Current_First%Surname > Stud_To_Check%Surname) then
              First => Find_First_Recursive(Stud_To_Check, Stud_To_Check%next)
           else if (Current_First%Surname == Stud_To_Check%Surname) then
              if (Current_First%Initial > Stud_To_Check%Initial) then
                  First => Find_First_Recursive(Stud_To_Check, Stud_To_Check%next)
              endif
           else
              First => Find_First_Recursive(Current_First, Stud_To_Check%next)
           endif
         else
            First => Current_First 
         endif
        
   end function Find_First_Recursive

   recursive function Find_Youngest_Recursive(Current_Young, Stud_To_Check) result(Youngest)
       
      type(student), allocatable, intent(in) :: Current_Young, Stud_To_Check
      
      type(student), allocatable             :: Youngest
     
      if (Allocated(Stud_To_Check)) then
        if (Current_Young%Year > Stud_To_Check%Year) then
           Youngest = Find_Youngest_Recursive(Stud_To_Check, Stud_To_Check%next)
        else 
           Youngest = Find_Youngest_Recursive(Current_Young, Stud_To_Check%next)
        endif
      else
           Youngest = Current_Young
      endif
  
   end function Find_Youngest_Recursive

end module Process   
