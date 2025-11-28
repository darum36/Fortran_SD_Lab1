program hw1_6_b_opt

   use Environment
   use Config
   use IO_Process
   use Process
   
   implicit none

   type(student), allocatable :: Group          
   type(student), allocatable :: FBA          
   type(student), allocatable :: Young          

   Group = Read_class(IN_FILE)

   if (Allocated(Group)) then

      call Write_Class(OUT_FILE, Group, "Исходный список:")

      FBA = Find_First_Recursive(Group, Group%next)
      call Write_Student(OUT_FILE, FBA, &
                          "Первый по алфавиту в списке:")
      
      Young = Find_Youngest_Recursive(Group, Group%next) 
      call Write_Student(OUT_FILE, Young, &
                         "Cамый молодой в списке:")
   endif

end program hw1_6_b_opt
