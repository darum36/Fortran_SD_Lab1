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

   subroutine read_students_list (Input_File, Surnames, Initials, Year)

      character(*),                                   intent(in)  :: Input_File 
      !DIR$ ATTRIBUTES ALIGN : 64 :: Surnames
      character(SURNAME_LEN,  kind=CH_), allocatable, intent(out) :: Surnames(:)
      !DIR$ ATTRIBUTES ALIGN : 64 :: Initials 
      character(INITIALS_LEN, kind=CH_), allocatable, intent(out) :: Initials(:)
      !DIR$ ATTRIBUTES ALIGN : 64 :: Year
      integer,                           allocatable, intent(out) :: Year(:)
      
      integer                                                     :: In, IO, i, Stud_Amount

      integer, parameter :: align_bytes = 64
      Stud_Amount = count_of_students(Input_File)

      allocate (Surnames(Stud_Amount))
      allocate (Initials(Stud_Amount))
      allocate (Year(Stud_Amount))

      open (file=Input_File, encoding=E_, newunit=In)
         read (In, S_FORMAT, iostat=IO) (Surnames(i), Initials(i), Year(i), &
                                                        i = 1, Stud_Amount)
      close (In)
  
   end subroutine read_students_list
  
   subroutine write_student_list(Output_File, Surnames, Initials, Year, Message)

      character(*),                      intent(in) :: Output_File, Message
      character(SURNAME_LEN,  kind=CH_), intent(in) :: Surnames(:)
      character(INITIALS_LEN, kind=CH_), intent(in) :: Initials(:)
      integer,                           intent(in) :: Year(:)
      
      integer                                       :: Out, IO, i

      open  (file=Output_File, encoding=E_, newunit=Out)
         write (Out, '(/a)') Message   
         write (Out, S_FORMAT, iostat=IO) (Surnames(i), Initials(i), Year(i), &
                                                           i = 1, size(Year))
      close (Out)

   end subroutine write_student_list

   subroutine write_student_by_index(Output_File, Surnames, Initials, Year, Stud_ind, Message)

      character(*),                      intent(in) :: Output_File, Message 
      character(SURNAME_LEN,  kind=CH_), intent(in) :: Surnames(:)
      character(INITIALS_LEN, kind=CH_), intent(in) :: Initials(:)
      integer,                           intent(in) :: Year(:)
      integer,                           intent(in) :: Stud_ind
      
      integer                                       :: Out, IO

      open (file=Output_File, encoding=E_, newunit=Out, position='append')
         write (Out, '(/a)') Message  
         write (Out, S_FORMAT, iostat=IO) Surnames(Stud_ind), Initials(Stud_ind), &
                                                                  Year(Stud_ind)
      close (Out)

   end subroutine write_student_by_index
   
end module IO_Process   
