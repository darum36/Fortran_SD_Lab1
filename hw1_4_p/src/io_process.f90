module IO_Process
   
   use Environment
   use Config
   
   implicit none

contains

   ! Получение кол-ва учеников
   function count_of_students(filename) result(n_stud)
      character(*), intent(in) :: filename
      integer                  :: n_stud
      integer                  :: In, IO
      
      n_stud = 0

      open(newunit=In, file=filename, action='read')
         read(In, *, iostat=IO)
         do while(IO == 0)
            read(In, *, iostat=IO)
            n_stud = n_stud + 1
         end do
      close (In)

   end function count_of_students

   ! создание системного файла
   subroutine create_data_file(Input_File, Output_File)
      character(*), intent(in)               :: Input_File, Output_File
      type(grp)                              :: Group_t
      integer                                :: In, Out, IO, i, Stud_Amount

      Stud_Amount = count_of_students(Input_File)

      allocate(Group_t%Surname(Stud_Amount), &
               Group_t%Initials(Stud_Amount), &
               Group_t%Year(Stud_Amount))

      Group_t%Surname  = ' '
      Group_t%Initials = ' '

      open(file=Input_File, encoding=E_, newunit=In) 
         do i = 1, Stud_Amount
            read(In, S_FORMAT, iostat=IO) Group_t%Surname(i)(1:FILE_SURNAME_LEN),   &
                                          Group_t%Initials(i)(1:FILE_INITIALS_LEN), &
                                          Group_t%Year(i)
         end do
      close (In)

      open(file=Output_File, form='unformatted', &
                   newunit=Out, access='stream')
         write(Out, iostat=IO) Group_t%Surname
         write(Out, iostat=IO) Group_t%Initials
         write(Out, iostat=IO) Group_t%Year
      close (Out)

      deallocate(Group_t%Surname, Group_t%Initials, Group_t%Year)

   end subroutine create_data_file

   ! получение списка всей группы студентов
   function read_student_list(Dat_file) result(Group)
      
      character(*), intent(in) :: Dat_file
      type(grp)                :: Group

      integer                  :: In, IO, Stud_Amount

      Stud_Amount = count_of_students(IN_FILE)

      allocate(Group%Surname(Stud_Amount), &
               Group%Initials(Stud_Amount), &
               Group%Year(Stud_Amount))

      open(file=Dat_file, form='unformatted', newunit=In, access='stream')
         read (In, iostat=IO) Group%Surname
         read (In, iostat=IO) Group%Initials
         read (In, iostat=IO) Group%Year
      close (In)

   end function read_student_list

   ! запись исходной группы  
   subroutine write_student_list(Output_File, Group, Message)

      type(grp),    intent(in)               :: Group
      character(*), intent(in)               :: Output_File, Message
            
      integer                                :: Out, IO, i

      open  (file=Output_File, encoding=E_, newunit=Out)
         write (Out, '(/a)') Message   
         do i = 1, size(Group%Year)
            write (Out, S_FORMAT, iostat=IO) Group%Surname(i)(1:FILE_SURNAME_LEN),  &
                                             Group%Initials(i)(1:FILE_INITIALS_LEN), &
                                             Group%Year(i)
         end do
      close (Out)

   end subroutine write_student_list

   ! запись одного стундента по индексу
   subroutine write_student_by_index(Output_File, Group, Stud_ind, Message)
      
      type(grp),     intent(in) :: Group
      character(*),  intent(in) :: Output_File, Message
      integer                   :: Stud_ind

      integer                   :: Out, IO

      
      open (file=Output_File, encoding=E_, newunit=Out, position='append')
         write (Out, '(/a)') Message
         write (Out, S_FORMAT, iostat=IO) Group%Surname(Stud_ind)(1:FILE_SURNAME_LEN),  &
                                          Group%Initials(Stud_ind)(1:FILE_INITIALS_LEN), &
                                          Group%Year(Stud_ind)
      close (Out)

   end subroutine write_student_by_index 

end module IO_Process   
