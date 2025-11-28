program hw1_6_a_opt

   use Environment
   use Config
   use IO_Process
   use Process
   
   implicit none

   type(student), pointer :: Group => Null()          
   type(student), pointer :: FBA => Null()          
   type(student), pointer :: Young => Null()          

   Group => Read_class(IN_FILE)

   if (Associated(Group)) then

      call Write_Class(OUT_FILE, Group, "Исходный список:")

      FBA => Find_First_Recursive(Group, Group%next)
      call Write_Student(OUT_FILE, FBA, &
                          "Первый по алфавиту в списке:")
      
      Young => Find_Youngest_Recursive(Group, Group%next) 
      call Write_Student(OUT_FILE, Young, &
                         "Cамый молодой в списке:")
   endif

end program hw1_6_a_opt
