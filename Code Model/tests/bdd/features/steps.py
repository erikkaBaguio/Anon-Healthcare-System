from lettuce import *


@step('The examination of the patient with id (\d+) is finished')
def examination_isFinished(step, patient_id):
    world.patient_id = request(int(patient_id))

@step('I request an appointment to doctor with id (\d+)')
def request_doctor(step, doctor_id):
    world.patient_id = request(int(doctor_id))

@step('I should get a (\d+) response')
def check_id(step, expected):
    expected = int(expected)
    assert world.patient_id == expected, \
        "Got %d" % world.number

def request(number):
    return 1