﻿using namespace std;
#include <string>
#include <iostream>
#include <optional>
#include <fstream>
#include <iomanip>

struct Arguments
{
	string inputFileName;
};

enum Errors {
	INPUT_FILE_WASNT_OPENED,
	INCORRECT_MATRIX,
};

const int MATRIX_SIZE = 3;
const int MINOR_SIZE = 2;
const int ARGUMENTS_COUNT = 2;

typedef double Matrix[MATRIX_SIZE][MATRIX_SIZE];
typedef double MinorMatrix[MINOR_SIZE][MINOR_SIZE];

optional <Arguments> GetArguments(int argc, char** argv)
{
	if (argc != ARGUMENTS_COUNT)
	{
		cout << "Invalid input" << endl;
		cout << "Usage: <inputFileName>" << endl;
		return nullopt;
	}

	Arguments arg;
	arg.inputFileName = argv[1];
	return arg;
}

bool OpenFileAndFillMatrix(optional<Arguments>& arg, Matrix& originalMatrix)
{
	ifstream inputFile;
	inputFile.open(arg->inputFileName);

	if (!inputFile.is_open())
	{
		cout << "Failed to open " << arg->inputFileName << " for reading" << endl;
		return false;
	}

	for (int i = 0; i < MATRIX_SIZE; i++)
	{
		for (int j = 0; j < MATRIX_SIZE; j++)
		{
			inputFile >> originalMatrix[i][j];
			if (inputFile.fail())
			{
				cout << "Incorrect matrix" << endl;
				cout << "Matrix should be 3x3 with digit elements" << endl;
				return false;
			}
		}
	}

	return true;
}

double GetMinor(const Matrix matrix, int row, int column)
{
	double minor;
	MinorMatrix minorMatrix;

	for (int i = 0, minorMatrixRow = 0; i < MATRIX_SIZE; i++)
	{
		if (i == row)
		{
			continue;
		}

		for (int j = 0, minorMatrixColumn = 0; j < MATRIX_SIZE; j++)
		{
			if (j == column)
			{
				continue;
			}
			minorMatrix[minorMatrixRow][minorMatrixColumn] = matrix[i][j];
			minorMatrixColumn++;
		}

		minorMatrixRow++;
	}

	minor = minorMatrix[0][0] * minorMatrix[1][1] - minorMatrix[0][1] * minorMatrix[1][0];
	return minor;
}

double GetDeterminant(const Matrix matrix) {

	double determinant = 0; 
	for (int j = 0; j < MATRIX_SIZE; j++)
	{
		determinant += matrix[0][j] * pow(-1, j) * GetMinor(matrix, 0, j); 
	}

	return determinant;
}

void GetAdjugateMatrix(Matrix& intermediaryMatrix, Matrix originalMatrix)
{
	for (int i = 0; i < MATRIX_SIZE; i++)
	{
		for (int j = 0; j < MATRIX_SIZE; j++)
		{
			intermediaryMatrix[j][i] = GetMinor(originalMatrix, i, j) * pow(-1, i+j);
		}
	}
}

void GetInversedMatrix(const Matrix intermediaryMatrix, Matrix& resultMatrix, double determinant)
{
	for (int i = 0; i < MATRIX_SIZE; i++)
	{
		for (int j = 0; j < MATRIX_SIZE; j++)
		{
			resultMatrix[i][j] = intermediaryMatrix[i][j] / determinant;

			if (resultMatrix[i][j] == -0)
			{
				resultMatrix[i][j] = 0;
			}
		}
	}
}

bool InverseMatrix(Matrix& matrix)
{
	double determinant; 

	determinant = GetDeterminant(matrix);
	if (determinant == 0)
	{
		cout << "Determinant is 0. Matrix is not invertible"<<endl;
		return false;
	}

	Matrix AdjugateMatrix;
	GetAdjugateMatrix(AdjugateMatrix, matrix);
	GetInversedMatrix(AdjugateMatrix, matrix, determinant);
	return true;
}

void ShowInvertedMatrix(Matrix& matrix)
{
	for (int i = 0; i < MATRIX_SIZE; i++)
	{
		for (int j = 0; j < MATRIX_SIZE; j++)
		{
			cout << setprecision(3) << matrix[i][j] << " ";
		}
		cout << endl;
	}
}

int main(int argc, char** argv)
{
	optional arg = GetArguments(argc, argv);

	if (!arg)
	{
		return 1;
	}

	Matrix matrix;

	if (!OpenFileAndFillMatrix(arg, matrix))
	{
		return 1;
	}
	
	if (!InverseMatrix(matrix))
	{
		return 1;
	}

	ShowInvertedMatrix(matrix);

	return 0;
}

