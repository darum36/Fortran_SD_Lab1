program lab_1_3_opt

   use Environment
   use Config
   use IO_Process
   use Process
   
   implicit none

   type(student), allocatable :: Group(:)
   integer                    :: first_by_alpha, younger

   call create_data_file(IN_FILE, DAT_FILE) 
   
   Group = read_student_list(DAT_FILE)

   call write_student_list(OUT_FILE, Group, "Исходный список:")

   first_by_alpha = find_first_by_alphabet(Group)
   call write_student_by_index(OUT_FILE, Group(first_by_alpha), &
                               "Первый по алфавиту в списке:")
   
   younger = find_younger(Group)                            
   call write_student_by_index(OUT_FILE, Group(younger), &
                               "Cамый молодой в списке:")

end program lab_1_3_opt
