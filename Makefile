ERL=erl

all: compile

compile:
	test -d ebin || mkdir ebin
	$(ERL) -make

clean:
	rm -rf ebin erl_crash.dump manager.conf snmpm_config_db
