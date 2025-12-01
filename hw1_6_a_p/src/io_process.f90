module IO_Process
   
   use Environment
   use Config
   
   implicit none

contains

   function Read_class(Input_File) result(Class_list)
      
      type(student), pointer   :: Class_list
      character(*), intent(in) :: Input_File
      
      Integer                  :: In

      open (file=Input_File, encoding=E_, newunit=In)
         Class_list => Read_Student(In)
      close (In)

      contains
         
         recursive function Read_Student(In) result(Stud)
         
            type(student), pointer :: Stud
            integer, intent(in)    :: In

            integer                :: IO
            
            allocate (Stud)
                
            read (In, S_FORMAT, iostat=IO) Stud%Surname(1:FILE_SURNAME_LEN),  &
                                           Stud%Initial(1:FILE_INITIALS_LEN), &
                                           Stud%Year
            if (IO == 0) then
               Stud%next => Read_Student(In)
            else 
               deallocate (Stud)
               Stud => Null()
            endif
         
         end function Read_Student

   end function Read_class

   subroutine Write_Class (Output_File, Class_List, Message)
      
      character(*),  intent(in) :: Output_File, Message
      type(student), intent(in) :: Class_List

      integer                   :: Out

      open (file=Output_File, encoding=E_, position='rewind', newunit=Out)
         write (out, '(/a)') Message
         call Output_Stud(Out, Class_list)
      close (Out)

      contains

         recursive subroutine Output_Stud(Out, Stud)
         
            integer,       intent(in) :: Out
            type(student), intent(in) :: Stud

            integer                   :: IO

            write (Out, S_FORMAT, iostat=IO) Stud%Surname(1:FILE_SURNAME_LEN),  &
                                             Stud%Initial(1:FILE_INITIALS_LEN), &
                                             Stud%Year
            if (Associated(Stud%next)) then
               call Output_Stud(Out, Stud%next)
            endif

         end subroutine Output_Stud

   end subroutine Write_Class

   
  subroutine Write_Student(Output_File, Stud, Message)
      
      character(*),  intent(in) :: Output_File, Message
      type(student), intent(in) :: Stud

      integer                   :: Out, IO

      open (file=Output_File, encoding=E_, position='append', newunit=Out)
         write (Out, '(/a)') Message
         write (Out, S_FORMAT, iostat=IO) Stud%Surname(1:FILE_SURNAME_LEN),  &
                                          Stud%Initial(1:FILE_INITIALS_LEN), &
                                          Stud%Year 
      close (Out)

   end subroutine Write_Student 

end module IO_Process   
