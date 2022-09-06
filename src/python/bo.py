from grongier.pex import BusinessOperation
from msg import FormationRequest,TrainingRequest,TrainingResponse,PatientRequest
import os
import iris
import psycopg2
import random
class FileOperation(BusinessOperation):
    """
    It is an operation that write a training or a patient in a file
    """
    def on_init(self):
        if hasattr(self,'path'):
            os.chdir(self.path)
        else:
            os.chdir("/tmp")
        if not hasattr(self,'filename'):
            self.filename = 'toto.csv'
        return None

    def write_training(self, request:TrainingRequest):
        """
        It writes a training to a file
        
        :param request: The request message
        :type request: TrainingRequest
        :return: None
        """
        room = name = ""
        if request.training is not None:
            room = request.training.room
            name = request.training.name
        line = room+" : "+name+"\n"
        filename = 'toto.csv'
        self.put_line(filename, line)
        return None

    def write_patient(self, request:PatientRequest):
        """
        It writes the name and average number of steps of a patient in a file
        
        :param request: The request message
        :type request: PatientRequest
        :return: None
        """
        name = ""
        avg = 0
        if request.patient is not None:
            name = request.patient.name
            avg = request.patient.avg
        line = name + " avg nb steps : " + str(avg) +"\n"
        filename = 'Patients.csv'
        self.put_line(filename, line)
        return None

    def on_message(self, request):
        return None

    def put_line(self,filename,string):
        """
        It opens a file, appends a string to it, and closes the file
        
        :param filename: The name of the file to write to
        :param string: The string to be written to the file
        """
        try:
            with open(filename, "a",encoding="utf-8",newline="") as outfile:
                outfile.write(string)
        except Exception as error:
            raise error



class IrisOperation(BusinessOperation):
    """
    It is an operation that write trainings in the iris database
    """

    def insert_training(self, request:TrainingRequest):
        """
        It takes a `TrainingRequest` object, inserts a new row into the `iris.training` table, and returns a
        `TrainingResponse` object
        
        :param request: The request object that will be passed to the function
        :type request: TrainingRequest
        :return: A TrainingResponse message
        """
        resp = TrainingResponse()
        resp.decision = round(random.random())

        sql = """
        INSERT INTO iris.training
        ( name, room )
        VALUES( ?, ? )
        """
        name = request.training.name
        room = request.training.room
        iris.sql.exec(sql,name,room)
        return resp
        
    def on_message(self, request):
        return None

class PostgresOperation(BusinessOperation):
    """
    It is an operation that write trainings in the Postgres database
    """

    def on_init(self):
        if not hasattr(self,'host'):
          self.host = 'db'
        if not hasattr(self,'database'):
          self.database = 'DemoData'
        if not hasattr(self,'user'):
          self.user = 'DemoData'
        if not hasattr(self,'password'):
          self.password = 'DemoData'
        if not hasattr(self,'port'):
          self.port = '5432'

        self.conn = psycopg2.connect(
        host=self.host,
        database=self.database,
        user=self.user,
        password=self.password,
        port=self.port)

        self.conn.autocommit = True

        return None

    def on_tear_down(self):
        """
        It closes the connection to the database
        :return: None
        """
        self.conn.close()
        return None

    def insert_training(self,request:TrainingRequest):
        """
        It inserts a training in the Postgres database
        
        :param request: The request object that will be passed to the function
        :type request: TrainingRequest
        :return: None
        """
        cursor = self.conn.cursor()
        sql = "INSERT INTO public.formation ( name,room ) VALUES ( %s , %s )"
        cursor.execute(sql,(request.training.name,request.training.room))
        return None
    
    def on_message(self,request):
        return None

class HelloWorldOperation(BusinessOperation):
    def on_message(self, request):
        self.log_info("Hello World !")
